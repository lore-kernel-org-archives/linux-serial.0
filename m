From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Subject: [PATCH v2 resend 0/2] RZ/G2[EM] SCIF and HSCIF documentation
Date: Wed, 19 Dec 2018 10:06:23 +0000
Message-ID: <1545213985-30341-1-git-send-email-fabrizio.castro@bp.renesas.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Fabrizio Castro <fabrizio.castro@bp.renesas.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Simon Horman <horms@verge.net.au>, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Chris Paterson <Chris.Paterson2@renesas.com>, Biju Das <biju.das@bp.renesas.com>, linux-renesas-soc@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hello Greg,

as promised I am resending the SCIF and HSCIF dt-bindings related
patches for the RZ/G2M and RZ/G2E.
This series applies on top of next-20181219.

Thanks,
Fab

Fabrizio Castro (2):
  dt-bindings: serial: sh-sci: Document r8a774a1 bindings
  dt-bindings: serial: sh-sci: Document r8a774c0 bindings

 .../devicetree/bindings/serial/renesas,sci-serial.txt    | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

-- 
2.7.4
