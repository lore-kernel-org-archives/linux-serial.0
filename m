From: Alan Cox <alan@linux.intel.com>
Subject: [PATCH] tty: Fix warning left over from TIOCGICOUNT changes
Date: Fri, 24 Sep 2010 15:49:18 +0100
Message-ID: <20100924144750.11385.24596.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
Sender: linux-next-owner@vger.kernel.org
To: linux-next@vger.kernel.org, greg@kroah.com, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/usb/serial/ssu100.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)


diff --git a/drivers/usb/serial/ssu100.c b/drivers/usb/serial/ssu100.c
index 8bd60e3..f5312dd 100644
--- a/drivers/usb/serial/ssu100.c
+++ b/drivers/usb/serial/ssu100.c
@@ -444,8 +444,6 @@ static int ssu100_ioctl(struct tty_struct *tty, struct file *file,
 		    unsigned int cmd, unsigned long arg)
 {
 	struct usb_serial_port *port = tty->driver_data;
-	struct ssu100_port_private *priv = usb_get_serial_port_data(port);
-	void __user *user_arg = (void __user *)arg;
 
 	dbg("%s cmd 0x%04x", __func__, cmd);
 


--
Elephants that sit in trees		Beware craters beneath trees
Really hate Dutch Elm disease		Lest they have Dutch Elm disease
In the boughs they sit and sun		For from on high there may thump
A branch gives way down they come	An elephant in a grump
Grumpily sat in the plants		In the bushes sat resigned
Picking splinters from their pants	Peeling you from his behind
