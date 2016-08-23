From: Piotr =?iso-8859-1?Q?Kr=F3l?= <piotr.krol-zILERgsGILsAvxtiuMwx3w@public.gmane.org>
Subject: Issue with high-speed UART on Allwinner A20
Date: Wed, 24 Aug 2016 00:03:31 +0200
Message-ID: <20160823220331.vauskx6hugjeow3x@haysend>
Reply-To: piotr.krol-zILERgsGILsAvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBDI3ZQEQAEILNEHTXUCRUBCFWX4VU-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: "\"linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org\" " <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Cc: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

Hi all,
we have custom board with Allwinner A20 and we try to configure
ttyS1-ttyS7 to use high speed configuration and set 921600 using:

stty -F /dev/ttyS1 921600

Unfortunately max what we can see using oscilloscope is 750000. Since sourc=
e
clock for UART defined by device tree on this platform is osc24M (24MHz
oscillator):

# cat /sys/class/tty/ttyS1/uartclk=20
24000000

If this is correct then only way to get 750000 is 64 divisor (CLK_RAT_N and
CLK_RAT_M). Not sure if value in sysfs should reflect that:

# cat /sys/class/tty/ttyS1/custom_divisor=20
0

I also can't change that value from root account getting 'permission denied=
'.

Anyone know what maybe issue with speed capped to 750000 ?

I found that some people had problems with error rate on higher speed
[1], but it was for legacy kernel. Is there a way to change APB1 clock
in device tree to something higher ? At this point in sun7i-a20.dtsi I
see pll6 which also seems to use osc24M.

Does anyone had experience in setting higher speed for UARTs using A20
chip ? What should approach for that ?

We have 4.7 kernel put together with uboot and rootfs using buildroot.
If I confuse something please let me know.

[1] http://linux-sunxi.narkive.com/thhIDej9/a20-high-speed-uart-problem

--=20
Best Regards,
Piotr Kr=C3=B3l
Embedded Systems Consultant
http://3mdeb.com | @3mdeb_com

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
