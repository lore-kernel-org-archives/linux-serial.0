From: Paul Bolle <pebolle@tiscali.nl>
Subject: [PATCH] [linux-next] sprd_serial: compile sprd_suspend and
 sprd_resume conditionally
Date: Tue, 03 Feb 2015 21:05:50 +0100
Message-ID: <1422993950.23894.16.camel@x220>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: Valentin Rothberg <valentinrothberg@gmail.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Building sprd_serial.o when CONFIG_PM_SLEEP is not defined triggers
these warnings:
    drivers/tty/serial/sprd_serial.c:755:12: warning: =E2=80=98sprd_sus=
pend=E2=80=99 defined but not used [-Wunused-function]
     static int sprd_suspend(struct device *dev)
                ^
    drivers/tty/serial/sprd_serial.c:764:12: warning: =E2=80=98sprd_res=
ume=E2=80=99 defined but not used [-Wunused-function]
     static int sprd_resume(struct device *dev)
                ^

Let's compile these functions only when CONFIG_PM_SLEEP is defined.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
The only reason I looked into this driver is because it landed in
today's linux-next (ie, next-20150203) and depends on ARCH_SPRD.
ARCH_SPRD is not yet included in linux-next. Since there was a patch
submitted on lkml recently to add that symbol that's not a big deal.
(That might change if that symbol doesn't make it into v3.20-rc[123] or
so.) But I did compile this file while looking into this issue.

Compile tested only, on x86_64, using the hacky
    make drivers/tty/serial/sprd_serial.o

way to compile this file!

 drivers/tty/serial/sprd_serial.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd=
_serial.c
index 594b63331ef4..be3ed3f4ad60 100644
--- a/drivers/tty/serial/sprd_serial.c
+++ b/drivers/tty/serial/sprd_serial.c
@@ -752,6 +752,7 @@ static int sprd_probe(struct platform_device *pdev)
 	return ret;
 }
=20
+#ifdef CONFIG_PM_SLEEP
 static int sprd_suspend(struct device *dev)
 {
 	struct sprd_uart_port *sup =3D dev_get_drvdata(dev);
@@ -769,6 +770,7 @@ static int sprd_resume(struct device *dev)
=20
 	return 0;
 }
+#endif
=20
 static SIMPLE_DEV_PM_OPS(sprd_pm_ops, sprd_suspend, sprd_resume);
=20
--=20
1.9.3
