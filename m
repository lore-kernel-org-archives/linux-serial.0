From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] serial: vt8500_serial: Fix a parameter of find_first_zero_bit.
Date: Tue, 23 Aug 2016 11:23:34 +0200
Message-ID: <11520879.bzQ3JxDSyK@wuerfel>
References: <1471814425-18949-1-git-send-email-christophe.jaillet@wanadoo.fr> <2512469.eM8MYFl15l@wuerfel> <57f44339-76c6-051f-b592-2648afaae336@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <57f44339-76c6-051f-b592-2648afaae336@wanadoo.fr>
Sender: kernel-janitors-owner@vger.kernel.org
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, linux@prisktech.co.nz, linux-serial@vger.kernel.org, jslaby@suse.com
List-Id: linux-serial@vger.kernel.org

On Tuesday, August 23, 2016 6:20:28 AM CEST Christophe JAILLET wrote:
> Le 22/08/2016 à 10:42, Arnd Bergmann a écrit :
> > [...]
> > Sorry, but I'm not following the logic here.
> >
> > [...]
> > You argue that the two have the same meaning, which I see, but
> > why is it better than the existing code?
> >
> > 	Arnd
> 
> Hi,
> 
> sorry if my explanation was unclear.
> 
> What I mean is that if "sizeof(unsigned long) = 4" (i.e. 32 bits systems 
> ?) then:
> 
> 	port = find_first_zero_bit(&vt8500_ports_in_use, sizeof(vt8500_ports_in_use));
> turns into:
>   	port = find_first_zero_bit(&vt8500_ports_in_use, 4);
> 
> find_first_zero_bit "Returns the bit number of the first set bit.  If no bits are set, returns @size."
> So, in this case, it can return 1, 2, 3 or 4, if one of the 4 first bits is 0.
> And will also return 4, if none of the 4 first bits is 0.

Ah, got it.

> 
> Finally, what I meant by "Other options are possible:" is:
>    - 'vt8500_ports_in_use' being a 'unsigned long', use ffz to reduce code verbosity
> 	port = ffz(&vt8500_ports_in_use);
>      would also work, because it is equivalent to:
> 	port = find_first_zero_bit(&vt8500_ports_in_use, BITS_PER_LONG);
> 
>    - VT8500_MAX_PORTS, in order to be consistent with the test below
> 	port = find_first_zero_bit(&vt8500_ports_in_use, VT8500_MAX_PORTS);
>      would also work and is maybe more logical in regard to the test "if (port >= VT8500_MAX_PORTS)"
> 
> 
> 
> Now if "sizeof(unsigned long) = 8" (i.e. 64 bits systems ?), the actual code would work.
> But using "sizeof(long)" to mean "more than VT8500_MAX_PORTS" is odd.
> In other words, expressing a number of bits using something that gives a size in bytes is, IMHO, spurious.
>   
> All this is pure speculation.
> 
> Hoping that it is clearer now ( and that my analysis is right :) )

I misread the code in the same way the original author wrote it wrong,
I guess it was meant to say

	port = find_first_zero_bit(&vt8500_ports_in_use, sizeof(vt8500_ports_in_use) * 8);

to convert number of bytes into number of bits. Your patch is absolutely
correct, but being more specific about the kind of mistake that was made
is a good idea.

Regarding which of the four alternatives to use, I'd probably use
your third one, checking against VT8500_MAX_PORTS. To make this code
absolutely foolproof, we can add this hunk too then:

diff --git a/drivers/tty/serial/vt8500_serial.c b/drivers/tty/serial/vt8500_serial.c
index 23cfc5e16b45..a68be66d2770 100644
--- a/drivers/tty/serial/vt8500_serial.c
+++ b/drivers/tty/serial/vt8500_serial.c
@@ -118,7 +118,7 @@ struct vt8500_port {
  * have been allocated as we can't use pdev->id in
  * devicetree
  */
-static unsigned long vt8500_ports_in_use;
+static DECLARE_BITMAP(vt8500_ports_in_use, VT8500_MAX_PORTS);
 
 static inline void vt8500_write(struct uart_port *port, unsigned int val,
 			     unsigned int off)



	Arnd
