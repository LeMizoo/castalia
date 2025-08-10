import HeroSection from '../components/ui/HeroSection';
import FounderCard from '../components/ui/FounderCard';
import TestimonyCard from '../components/ui/TestimonyCard';
import SanctuaryMap from '../components/ui/SanctuaryMap';
import SpiritualReflection from '../components/ui/SpiritualReflection';

export default function Home() {
  return (
    <>
      <HeroSection
        title="🎶 C.A.S.T. – Quand l’art devient prière"
        subtitle="La musique touche l’âme, la foi devient vibration"
        background="/src/assets/images/rosace.jpg"
      />

      <FounderCard
        name="S.E. Liva ANDRIAMANALINARIVO"
        role="Visionnaire spirituel"
        description="Un pont entre ciel et terre, enraciné dans les traditions chrétiennes malgaches."
      />

      <TestimonyCard
        name="Lucien Emmanuel RANDRIANARIVELO (†)"
        quote="Ianao no nandika sy nandray ny feon’ny lanitra ho tenin’ny tanindrazana."
        description="Transcripteur, traducteur, artisan du sacré."
      />

      <SanctuaryMap
        locations={[
          { name: "Cathédrale d’Andohalo", description: "Rosace céleste" },
          { name: "Saint Michel Itaosy", description: "Tambour spirituel" },
          { name: "FJKM Andakana", description: "Voûte vibrante" }
        ]}
      />

      <SpiritualReflection
        texts={[
          "Méditations guidées",
          "Prières et versets",
          "Témoignages de transformation"
        ]}
      />
    </>
  );
}