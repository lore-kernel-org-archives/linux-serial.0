From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 1/3] [net-next] net: remove netx ethernet driver
Date: Mon, 22 Jul 2019 18:14:04 -0700 (PDT)
Message-ID: <20190722.181404.2250205918210350551.davem@davemloft.net>
References: <20190722191304.164929-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190722191304.164929-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: arnd@arndb.de
Cc: netdev@vger.kernel.org, linux-serial@vger.kernel.org, tglx@linutronix.de, gregkh@linuxfoundation.org, s.hauer@pengutronix.de, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 22 Jul 2019 21:12:31 +0200

> The ARM netx platform got removed in 5.3, so this driver
> is now useless.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: David S. Miller <davem@davemloft.net>

(btw two copies of this went out for some reason)
