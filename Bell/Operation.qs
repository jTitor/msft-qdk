namespace Bell
{
    open Microsoft.Quantum.Primitive;

    operation Set (desired: Result, q1: Qubit) : ()
    {
        body
        {
            //Measure the qubit.
            let current = M(q1);
            //If it doesn't match what we want,
            //negate its state with Pauli X.
            if(desired != current)
            {
                X(q1);
            }   
        }
    }

    operation BellTest (count : Int, initial: Result) : (Int,Int)
    {
        body
        {
            //Set up a counter so we can validate
            //measurement distributions.
            mutable numOnes = 0;

            using (qubits = Qubit[1])
            {
                for (test in 1..count)
                {
                    //Use our Set() operation
                    //to make our qubit the desired value of \ket{1},
                    //but *don't* measure them just yet.
                    Set (initial, qubits[0]);

                    //Measure so we can get the state...
                    let res = M(qubits[0]);

                    //...and if it was \ket{1},
                    //update the counter.
                    if (res == One)
                    {
                        set numOnes = numOnes + 1;
                    }
                }

                //Call Set(0) to reset the variable.
                Set(Zero, qubits[0]);

                //Now return our frequencies of
                //\ket{0} and \ket{1}.
                return (count-numOnes, numOnes);
            }
        }
    }
}
