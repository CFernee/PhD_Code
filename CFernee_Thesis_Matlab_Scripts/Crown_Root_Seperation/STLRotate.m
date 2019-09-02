function [RotatedTarget]=STLRotate(Baseline,Target)

[Points_Moved,M]=ICP_finite(Baseline.vertices, Target.vertices, struct('Registration','Rigid'));

Target.vertices=Points_Moved;

RotatedTarget=Target;

end