trigger OrderItemObject on OrderItem (after insert, after update) {
    if(Trigger.isAfter){
			OrderItemHandler.calculMontant(trigger.new);
	}

}