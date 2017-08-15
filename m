From: Timur Tabi <timur@tabi.org>
Subject: Re: [PATCH 05/11] serial: uuc_uart: constify uart_ops structures
Date: Tue, 15 Aug 2017 09:44:39 -0500
Message-ID: <b5eaeaab-6c8b-b4d1-5667-a879cdda4019@tabi.org>
References: <1502605310-4314-1-git-send-email-Julia.Lawall@lip6.fr>
 <1502605310-4314-6-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1502605310-4314-6-git-send-email-Julia.Lawall@lip6.fr>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: bhumirks@gmail.com, kernel-janitors@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 8/13/17 1:21 AM, Julia Lawall wrote:
> These uart_ops structures are only stored in the ops field of a
> uart_port structure and this fields is const, so the uart_ops
> structures can also be const.
> 
> Done with the help of Coccinelle.
> 
> Signed-off-by: Julia Lawall<Julia.Lawall@lip6.fr>

Acked-by: Timur Tabi <timur@tabi.org>
