#! @Chapter Constructing a Fusion System
#! 
#! There are 4 ways to define a fusion system $\calF$ on a $p$-group $P$:
#! 
#! * a fusion system $\calF = \calF_P(G)$ realized by an overgroup $G$, `RealizedFusionSystem(G, P, p)`;
#! * a transported fusion system $\calF = \calE^\phi$ given another fusion system $\calE$ and an isomorphism $\phi \colon Q \to P$, `TransportFusionSystem(F, phi)`;
#! * a fusion system generated by a list of injective maps `l`, `GeneratedFusionSystem(P, l)`; and 
#! * the universal fusion system $\calF$, `UniversalFusionSystem(P, p)`.

#! @Section Realized Fusion System
#! 
#! Let $G$ be a finite group and $P$ a $p$-subgroup of $G$. The realized fusion system $\calF_P(G)$ is a fusion system on $P$, where $\Hom_\calF(A, B)$ consists of all those maps $\phi \colon A \to B$ where $\phi$ is induced by some some $g \in G$, i.e. $\phi = c_g$ on $A$.

DeclareRepresentation("IsRealizedFusionSystemRep", 
    IsComponentObjectRep and IsFusionSystem, ["G", "P", "p", "IsSylowSubgroup"]);

#! @Description
#! Given a finite group $G$ and a $p$-subgroup $P$, returns the fusion system $\calF_P(G)$.
#! 
#! @Arguments G P
#! @Returns a fusion system
DeclareOperation("RealizedFusionSystem", [IsGroup, IsGroup]);

#! @BeginExample
#! gap> G := AlternatingGroup(4);
#! Alt( [ 1 .. 4 ] )
#! gap> P := SylowSubgroup(G, 2);
#! Group([ (1,2)(3,4), (1,3)(2,4) ])
#! gap> F := RealizedFusionSystem(G, P);
#! Fusion System on Group( [ (1,2)(3,4), (1,3)(2,4) ] )
#! @EndExample

#! @Description
#! Given a realized fusion system $\calF_P(G)$ with $G$ a finite group and $P$ a $p$-subgroup of $G$, returns $G$.
#! 
#! @Arguments F
#! @Returns a group
DeclareAttribute("RealizingGroup", IsRealizedFusionSystemRep);

#! @Section Transport Fusion System
#! Let $\calF$ be a fusion system on a finite $p$-group $P$, and let $\phi \colon P \to Q$ be an isomorphism. The transport fusion system $\calE = \calF^\phi$ is a fusion system on $Q$ where a map $\psi \in \Hom_\calF(A, B)$ if and only if $\psi^\phi \in \Hom_\calE(A^\phi, B^\phi)$.

DeclareRepresentation("IsTransportFusionSystemRep", 
    IsComponentObjectRep and IsFusionSystem, ["fusion", "group", "phi", "phiInv"]);

#! @Description
#! 
#! Given a fusion system $\calF$ on a finite $p$-group $P$, and a group isomorphism $\phi \colon P \to Q$, returns the fusion system $\calF^\phi$.
#! 
#! @Arguments F phi
#! @Returns a fusion system
DeclareOperation("\^", [IsFusionSystem, IsGroupHomomorphism]);

#! @BeginExample
#! gap> G := AlternatingGroup(4);
#! Alt( [ 1 .. 4 ] )
#! gap> P := SylowSubgroup(G, 2);
#! Group([ (1,2)(3,4), (1,3)(2,4) ])
#! gap> F := RealizedFusionSystem(G, P);
#! Fusion System on Group( [ (1,2)(3,4), (1,3)(2,4) ] )
#! gap> phi := ConjugatorIsomorphism(P, (1,2,3));
#! ^(1,2,3)
#! gap> T := F^phi;
#! Fusion System on Group( [ (1,4)(2,3), (1,2)(3,4) ] )
#! @EndExample

#! @Section Universal Fusion System
#! 
#! Let $P$ be a finite $p$-group. The universal fusion system $\calU(P)$ is a fusion system on $P$, where for any $A, B \leq P$ and an injective homomorphism $\phi \colon A \to B$, the map $\phi$ lies in $\Hom_{\calU(P)}(A, B)$.

DeclareRepresentation("IsUniversalFusionSystemRep", 
    IsComponentObjectRep and IsFusionSystem, ["P", "Subs", "p"]);

#! @Description
#! Given a finite $p$-group $P$, constructs the universal fusion system on $P$.
#! @Arguments P
#! @Returns a fusion system
DeclareOperation("UniversalFusionSystem", [IsGroup]);

#! @BeginExample
#! gap> P := Group([ (1,2,3,4), (1,3)]);
#! Group([ (1,2,3,4), (1,3) ])
#! gap> U := UniversalFusionSystem(P);
#! Universal Fusion System on Group( [ (1,2,3,4), (1,3) ] )
#! @EndExample

#! @Section Generated Fusion System
#! 
#! Let $P$ be a finite $p$-group and $L$ a list of injective homomorphisms between subgroups of $P$. The fusion system $\calF$ generated by $L$ is the smallest fusion system containing all the maps in $L$.
#! 
#! There are 2 types of generated fusion systems- one that generates from the inner fusion system (i.e. purely based on the maps), and one that generates from a different fusion system $\calE$ on $P$. The resulting fusion system, in that case, is the smallest fusion system containing all the maps in $L$ and $\calE$. 

DeclareRepresentation("IsGeneratedFusionSystemRep", 
    IsComponentObjectRep and IsFusionSystem, ["F", "Reps", "Isoms", "ClassReps", "NewFAuts"]);

#! @BeginGroup
#! @Description
#! Let $P$ be a finite $p$-group, and $L$ a list of injective group homomorphisms between subgroups of $P$.
#! 
#! If $\calF$ is a fusion system on $P$, the operation `GeneratedFusionSystem(F, L)` constructs the fusion system $\calE$ on $P$ generated by all maps in $F$ and $L$.
#!
#! The operation `GeneratedFusionSystem(P, L)` constructs the fusion system generated by the maps in $L$.
#! 
#! @Arguments F L
#! @Returns a fusion system
DeclareOperation("GeneratedFusionSystem", [IsFusionSystem, IsListOrCollection]);
#! @Arguments P L
#! @Returns a fusion system
DeclareOperation("GeneratedFusionSystem", [IsGroup, IsListOrCollection]);
#! @EndGroup

#! @BeginExample
#! gap> P := Group([ (1,2,3,4), (1,3)]);
#! Group([ (1,2,3,4), (1,3) ])
#! gap> A := Group((2,4), (1,3)(2,4));
#! Group([ (2,4), (1,3)(2,4) ])
#! gap> B := Group((1,2)(3,4), (1,3)(2,4));
#! Group([ (1,2)(3,4), (1,3)(2,4) ])
#! gap> phiA := GroupHomomorphismByImages(A, [A.1, A.2], [A.2, A.2*A.1]);
#! [ (2,4), (1,3)(2,4) ] -> [ (1,3)(2,4), (1,3) ]
#! gap> phiB := GroupHomomorphismByImages(B, [B.1, B.2], [B.2, B.2*B.1]);
#! [ (1,2)(3,4), (1,3)(2,4) ] -> [ (1,3)(2,4), (1,4)(2,3) ]
#! gap> F1 := GeneratedFusionSystem(P, [phiA]);
#! Fusion System on Group( [ (1,2,3,4), (1,3) ] )
#! gap> F2 := GeneratedFusionSystem(F1, [phiB]);
#! Fusion System on Group( [ (1,2,3,4), (1,3) ] )
#! @EndExample
