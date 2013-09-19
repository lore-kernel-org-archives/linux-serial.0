From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH tty-next 0/1] premature tty_port destruction diagnostic
Date: Wed, 18 Sep 2013 20:42:38 -0400
Message-ID: <1379551359-15000-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Hi Greg,

Now that the bluetooth rfcomm tty refcounting is fixed in linux-next,
I'd like to add this patch which aborts tty_port destruction if the
tty has not yet been released. At least this problem won't show up
as some random memory corruption (as was happening with rfcomm).

Even though this only WARNs, the machine is likely to crash anyway
because the port indexes will not be in sync; the tty layer will
assume the port has been destructed while the tty_port obviously
has not.

Regards,

Peter Hurley (1):
  tty: Prevent tty_port destruction if tty not released

 drivers/tty/tty_port.c | 4 ++++
 1 file changed, 4 insertions(+)

-- 
1.8.1.2
