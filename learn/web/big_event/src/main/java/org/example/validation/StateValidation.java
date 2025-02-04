package org.example.validation;

import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;
import org.example.anno.State;

public class StateValidation implements ConstraintValidator<State,String> {

    /**
     *
     * @param value 将来要校验的数据
     * @param context
     * @return 如果返回false校验不通过 true校验通过
     */

    @Override
    public boolean isValid(String value, ConstraintValidatorContext context) {
        //提供校验规则
        if(value == null){
            System.out.println("校验规则 value == null");
            return false;
        }

        if(value.equals("已发布") || value.equals("草稿")){
            System.out.println("校验规则 类型校验通过");
            return true;
        }

        return false;
    }
}
