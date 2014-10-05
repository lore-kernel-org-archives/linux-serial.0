From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 12/13 linux-next] serial: use container_of to resolve
 uart_sunzilog_port from uart_port
Date: Sun, 05 Oct 2014 16:58:05 -0400 (EDT)
Message-ID: <20141005.165805.1091863477799185135.davem@davemloft.net>
References: <1412528475-1449-1-git-send-email-fabf@skynet.be>
	<1412529589-1753-1-git-send-email-fabf@skynet.be>
	<1412529589-1753-3-git-send-email-fabf@skynet.be>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <sparclinux-owner@vger.kernel.org>
In-Reply-To: <1412529589-1753-3-git-send-email-fabf@skynet.be>
Sender: sparclinux-owner@vger.kernel.org
To: fabf@skynet.be
Cc: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, jslaby@suse.cz, sparclinux@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

From: Fabian Frederick <fabf@skynet.be>
Date: Sun,  5 Oct 2014 19:19:48 +0200

> Use container_of instead of casting first structure member.
> 
> Signed-off-by: Fabian Frederick <fabf@skynet.be>

Acked-by: David S. Miller <davem@davemloft.net>
