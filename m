From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 2/2] ipwireless: don't oops if we run out of space
Date: Thu, 01 Nov 2012 16:45:49 +0000
Message-ID: <20121101164401.31727.74769.stgit@bob.linux.org.uk>
References: <20121101164336.31727.23069.stgit@bob.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:34912 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932447Ab2KAQn4 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 1 Nov 2012 12:43:56 -0400
In-Reply-To: <20121101164336.31727.23069.stgit@bob.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: greg@kroah.com, linux-serial@vger.kernel.org

From: Alan Cox <alan@linux.intel.com>

Resolves-bug: https://bugzilla.kernel.org/show_bug.cgi?id=49851
Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/tty/ipwireless/network.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)


diff --git a/drivers/tty/ipwireless/network.c b/drivers/tty/ipwireless/network.c
index 57102e6..c0dfb64 100644
--- a/drivers/tty/ipwireless/network.c
+++ b/drivers/tty/ipwireless/network.c
@@ -352,6 +352,8 @@ static struct sk_buff *ipw_packet_received_skb(unsigned char *data,
 	}
 
 	skb = dev_alloc_skb(length + 4);
+	if (skb == NULL)
+		return NULL;
 	skb_reserve(skb, 2);
 	memcpy(skb_put(skb, length), data, length);
 
@@ -397,7 +399,8 @@ void ipwireless_network_packet_received(struct ipw_network *network,
 
 				/* Send the data to the ppp_generic module. */
 				skb = ipw_packet_received_skb(data, length);
-				ppp_input(network->ppp_channel, skb);
+				if (skb)
+					ppp_input(network->ppp_channel, skb);
 			} else
 				spin_unlock_irqrestore(&network->lock,
 						flags);

