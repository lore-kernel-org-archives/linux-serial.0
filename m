From: Sean Wang <sean.wang@mediatek.com>
Subject: Re: [PATCH v2 RESEND 1/2] dt-bindings: serial: 8250: Add MediaTek
 BTIF controller bindings
Date: Mon, 28 Aug 2017 03:39:45 +0800
Message-ID: <1503862785.19230.76.camel@mtkswgap22>
References: <cover.1503165144.git.sean.wang@mediatek.com>
         <29b52a3b95982f1097766d515aae09c57e11b002.1503165144.git.sean.wang@mediatek.com>
         <8548a72a-4bf3-d44a-6d26-d64721cffe85@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8548a72a-4bf3-d44a-6d26-d64721cffe85@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Brugger <matthias.bgg@gmail.com>
Cc: robh+dt@kernel.org, gregkh@linuxfoundation.org, jslaby@suse.com, andriy.shevchenko@linux.intel.com, robert.jarzmik@free.fr, arnd@arndb.de, p.zabel@pengutronix.de, joel@jms.id.au, david@lechnology.com, jan.kiszka@siemens.com, heikki.krogerus@linux.intel.com, hpeter@gmail.com, vigneshr@ti.com, tthayer@opensource.altera.com, devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Sun, 2017-08-27 at 22:00 +0300, Matthias Brugger wrote:
> 
> On 08/19/2017 09:06 PM, sean.wang@mediatek.com wrote:
> > From: Sean Wang <sean.wang@mediatek.com>
> > 
> > Document the devicetree bindings in 8250.txt for MediaTek BTIF
> > controller which could be found on MT7622 and MT7623 SoC.
> > 
> > Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> > ---
> >   Documentation/devicetree/bindings/serial/8250.txt | 3 +++
> >   1 file changed, 3 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/serial/8250.txt b/Documentation/devicetree/bindings/serial/8250.txt
> > index 419ff6c..7528d90 100644
> > --- a/Documentation/devicetree/bindings/serial/8250.txt
> > +++ b/Documentation/devicetree/bindings/serial/8250.txt
> > @@ -14,6 +14,9 @@ Required properties:
> >   	  tegra132, or tegra210.
> >   	- "nxp,lpc3220-uart"
> >   	- "ralink,rt2880-uart"
> > +	- For MediaTek MT7623, must contain "mediatek,mt7623-btif"
> > +	- For other MediaTek SoCs , must contain "mediatek,<chip>-btif",
> > +	  "mediatek,mt7623-btif" where <chip> is mt7622.
> 
> Hm, to me that's confusing. What about:
> "mediatek,mt7623-btif": for MediaTek MT7623
> "mediatek,mt7622-btif", "mediatek,mt7623-btif": for MediaTek MT7622
> 
> If in the future we have more SoCs that support the BTIF, we should add them 
> like the mt7622 case.
> 

I had v3, but it should have similar logic and also got ack from Rob

I knew all your logic of adding binding document for all MediaTek
devices, even I alway added MediaTek device in dt-bindings as the way
you mentioned here, but I felt this way is fine for this kind of
dedicated document.

The reason i don't add it as usual is the following. 8250.txt is common
and shared among all uart like devices, so i don't want btif device
occupies too much section and bloat the document when every new MediaTek
SoC is introduced. 

So instead I refer to existing Nvidia device added in 8250.txt  which I
thought its way is simple, elegant and also using pattern I can use to
add btif devices.

	Sean

> Make sense?
> 
> Regards,
> Matthias
