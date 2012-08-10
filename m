From: Stanislav Kozina <skozina@redhat.com>
Subject: [PATCH] Remove BUG_ON from n_tty_read()
Date: Fri, 10 Aug 2012 12:51:30 +0200
Message-ID: <5024E7B2.4030205@redhat.com>
References: <4FE886C6.7090606@redhat.com> <20120626152159.2a34dcaf@pyramind.ukuu.org.uk> <50094C8E.5010308@redhat.com> <20120720161123.58fc9703@pyramind.ukuu.org.uk> <50221C30.20607@redhat.com> <20120808100019.6ca011a9@pyramind.ukuu.org.uk> <502256E8.5040300@redhat.com> <5022779F.8060309@redhat.com> <20120808162725.713e7a61@pyramind.ukuu.org.uk> <50239DFA.1090004@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:19997 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757957Ab2HJKvl (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 10 Aug 2012 06:51:41 -0400
In-Reply-To: <50239DFA.1090004@redhat.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, Stanislaw Gruszka <sgruszka@redhat.com>

Change the BUG_ON to WARN_ON and return in case of tty->read_buf==NULL

Signed-off-by: Stanislav Kozina <skozina@redhat.com>
---
  drivers/tty/n_tty.c |    5 ++++-
  1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index df21f39..39c6202 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -1728,7 +1728,10 @@ static ssize_t n_tty_read(struct tty_struct *tty, 
struct file *file,

  do_it_again:

-	BUG_ON(!tty->read_buf);
+	if (!tty->read_buf) {
+		WARN_ON(!tty->read_buf);
+		return -EAGAIN;
+	}

  	c = job_control(tty, file);
  	if (c < 0)
-- 
1.7.1
