From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] drivers/tty: add missing of_node_put()
Date: Sun, 02 Dec 2018 20:55:53 -0800 (PST)
Message-ID: <20181202.205553.1761964091979889282.davem@davemloft.net>
References: <20181121152254.23480-1-tiny.windzz@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181121152254.23480-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tiny.windzz@gmail.com
Cc: gregkh@linuxfoundation.org, jslaby@suse.com, sparclinux@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

From: Yangtao Li <tiny.windzz@gmail.com>
Date: Wed, 21 Nov 2018 10:22:54 -0500

> of_find_node_by_path() acquires a reference to the node
> returned by it and that reference needs to be dropped by its caller.
> This place is not doing this, so fix it.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>

Applied.
