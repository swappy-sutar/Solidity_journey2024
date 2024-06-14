// SPDX-License-Identifier: MIT
pragma solidity 0.8.0;


    contract A {
        event log(string message);

        function foo()public virtual  {
            emit log("A.Foo called");
        }

        function bar()public virtual  {
            emit log("A.bar called");
        }
    } 

    contract B is A{
 
        function foo()public virtual override  {
            emit log("B.Foo called");
            A.foo();
        }

         function bar()public virtual override  {
            emit log("B.bar called");
            super.bar();
        }

    }

   contract C is A{
 
        function foo()public virtual override  {
            emit log("C.Foo called");
            A.foo();
        }

         function bar()public virtual override  {
            emit log("C.bar called");
            super.bar();
        }

    }

    contract D is B, C{
        function foo()public override (B,C){
            super.foo();
        }

        function bar() public override (B,C){
            super.bar();
        }
    }
