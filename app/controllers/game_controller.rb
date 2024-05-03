class GameController < ApplicationController

    def index 
        session[:money] ||= 500
        session[:chances] ||= 10
        session[:start_game] ||= false
    
        @money = session[:money]
        @chances = session[:chances]
        @message = session[:message] || []
        @start_game = session[:start_game]
    end 

    def bet 
        require 'date'
        Time.zone = 'Asia/Manila'
        current_timestamp = Time.zone.now.strftime('%m/%d/%Y %I:%M%p')
    
        risk_values = {
            "Low Risk" => "bet_low",
            "Moderate Risk" => "bet_moderate",
            "High Risk" => "bet_high",
            "Severe Risk" => "bet_severe"
        }  
    
        money = session[:money]
        session[:message] ||= []
        chances = session[:chances]
    
        if chances > 0 
            risk_values.each do |risk, risk_levels|
                if params[risk_levels].present?
                    result = stakes(risk)
                    loss = result > 0 ? false : true
                    money += result
    
                    bet_message = "#{current_timestamp}: You pushed #{risk}. Value is #{result}. Your current money now is #{money}"
                    session[:message].push([bet_message, loss])
                end
            end
    
            session[:money] = money
            session[:chances] -= 1
        else
            session[:start_game] = false
        end
    
        redirect_to root_path
    end
    

    def stakes(risk)
        stakes = {
            "Low Risk" => rand(-100..100),
            "Moderate Risk" => rand(-500..500),
            "High Risk" => rand(-2500..2500),
            "Severe Risk" => rand(-5000..5000)
        }
      
        draw = stakes[risk]
      end
      
      def process_game
        has_started = session[:start_game]
      
        if has_started == false 
          start
        else 
          reset
        end
      end
      
      private 
      
      def start 
        session[:start_game] = true 
        redirect_to root_path
      end
      
      def reset 
        session[:money] = 500
        session[:chances] = 10
        session[:start_game] = false
        session[:message] = []
        redirect_to root_path
      end

end
