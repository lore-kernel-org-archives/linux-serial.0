From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 04/11] serial: sunsu: constify uart_ops structures
Date: Sun, 13 Aug 2017 20:12:49 -0700 (PDT)
Message-ID: <20170813.201249.2185788172171274506.davem@davemloft.net>
References: <1502605310-4314-1-git-send-email-Julia.Lawall@lip6.fr>
        <1502605310-4314-5-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1502605310-4314-5-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Julia.Lawall@lip6.fr
Cc: bhumirks@gmail.com, kernel-janitors@vger.kernel.org, gregkh@linuxfoundation.org, jslaby@suse.com, sparclinux@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

From: Julia Lawall <Julia.Lawall@lip6.fr>
Date: Sun, 13 Aug 2017 08:21:43 +0200

> These uart_ops structures are only stored in the ops field of a
> uart_port structure and this fields is const, so the uart_ops
> structures can also be const.
> 
> Done with the help of Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Acked-by: David S. Miller <davem@davemloft.net>
