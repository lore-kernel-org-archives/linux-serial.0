From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 08/13 linux-next] serial: sunsu: use container_of to
 resolve uart_sunsu_port from uart_port
Date: Sun, 05 Oct 2014 16:57:50 -0400 (EDT)
Message-ID: <20141005.165750.1917530186306954555.davem@davemloft.net>
References: <1412528475-1449-1-git-send-email-fabf@skynet.be>
	<1412528475-1449-9-git-send-email-fabf@skynet.be>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:54814 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751612AbaJEU5x (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 5 Oct 2014 16:57:53 -0400
In-Reply-To: <1412528475-1449-9-git-send-email-fabf@skynet.be>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: fabf@skynet.be
Cc: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, jslaby@suse.cz, sparclinux@vger.kernel.org, linux-serial@vger.kernel.org

From: Fabian Frederick <fabf@skynet.be>
Date: Sun,  5 Oct 2014 19:01:09 +0200

> Use container_of instead of casting first structure member.
> 
> Signed-off-by: Fabian Frederick <fabf@skynet.be>

Acked-by: David S. Miller <davem@davemloft.net>
