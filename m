From: Badari Pulavarty <pbadari@us.ibm.com>
Subject: [KJ] [PATCH] stallion multiport driver missing request_region()
Date: Thu, 28 Sep 2006 11:30:09 -0700
Message-ID: <1159468209.1709.79.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <kernel-janitors-bounces@lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/kernel-janitors>,
	<mailto:kernel-janitors-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/kernel-janitors>
List-Post: <mailto:kernel-janitors@lists.osdl.org>
List-Help: <mailto:kernel-janitors-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/kernel-janitors>,
	<mailto:kernel-janitors-request@lists.osdl.org?subject=subscribe>
Sender: kernel-janitors-bounces@lists.osdl.org
Errors-To: kernel-janitors-bounces@lists.osdl.org
To: linux-serial@vger.kernel.org, kernel-janitors@lists.osdl.org
List-Id: linux-serial@vger.kernel.org

stl_initeio() doesn't release the regions in failure cases.

Signed-off-by: Badari Pulavarty <pbadari@us.ibm.com>

 drivers/char/stallion.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

Index: linux-2.6.18/drivers/char/stallion.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.18.orig/drivers/char/stallion.c	2006-09-19 20:42:06.000000000=
 -0700
+++ linux-2.6.18/drivers/char/stallion.c	2006-09-28 11:51:35.000000000 -0700
@@ -2265,10 +2265,16 @@ static inline int stl_initeio(stlbrd_t *
 			brdp->nrports =3D 16;
 			break;
 		default:
+			release_region(brdp->ioaddr1, brdp->iosize1);
+			if (brdp->iosize2 > 0)
+				release_region(brdp->ioaddr2, brdp->iosize2);
 			return(-ENODEV);
 		}
 		break;
 	default:
+		release_region(brdp->ioaddr1, brdp->iosize1);
+		if (brdp->iosize2 > 0)
+			release_region(brdp->ioaddr2, brdp->iosize2);
 		return(-ENODEV);
 	}
 =

@@ -2281,6 +2287,9 @@ static inline int stl_initeio(stlbrd_t *
 	if (!panelp) {
 		printk(KERN_WARNING "STALLION: failed to allocate memory "
 			"(size=3D%Zd)\n", sizeof(stlpanel_t));
+		release_region(brdp->ioaddr1, brdp->iosize1);
+		if (brdp->iosize2 > 0)
+			release_region(brdp->ioaddr2, brdp->iosize2);
 		return -ENOMEM;
 	}
 =

@@ -2305,6 +2314,9 @@ static inline int stl_initeio(stlbrd_t *
 	if (request_irq(brdp->irq, stl_intr, IRQF_SHARED, name, brdp) !=3D 0) {
 		printk("STALLION: failed to register interrupt "
 		    "routine for %s irq=3D%d\n", name, brdp->irq);
+		release_region(brdp->ioaddr1, brdp->iosize1);
+		if (brdp->iosize2 > 0)
+			release_region(brdp->ioaddr2, brdp->iosize2);
 		rc =3D -ENODEV;
 	} else {
 		rc =3D 0;
