from typing import Callable, Dict, Optional

from PyQt5 import QtWidgets

from .q1_rice_cooker.q1_activity import Q1RiceCooker
from .q2_dalat_fog.q2_activity import Q2DalatFog
from .q3_mangrove.q3_activity import Q3Mangrove
from .q4_ice_glass.q4_activity import Q4IceGlass
from .q5_sea_salt.q5_activity import Q5SeaSalt
from .q6_rainbow.q6_activity import Q6Rainbow

ActivityFactory = Callable[[], QtWidgets.QWidget]


_REGISTRY: Dict[int, ActivityFactory] = {
    1: Q1RiceCooker,
    2: Q2DalatFog,
    3: Q3Mangrove,
    4: Q4IceGlass,
    5: Q5SeaSalt,
    6: Q6Rainbow,
}


def create_activity(question_id: int) -> Optional[QtWidgets.QWidget]:
    factory = _REGISTRY.get(question_id)
    if not factory:
        return None
    return factory()
