From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH] tty: serial: serial_core.c: printk replacement
Date: Mon, 18 Aug 2014 14:25:53 +0200
Message-ID: <53F1F0D1.6070102@suse.cz>
References: <1407242145-3132-1-git-send-email-sudipm.mukherjee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1407242145-3132-1-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 08/05/2014, 02:35 PM, Sudip Mukherjee wrote:
> printk replaced with corresponding dev_err, dev_alert, dev_notice and pr_info.
> pr_info has been used instead of dev_info as there is a check for port->dev being NULL or not.
> fixed two broken user-visible strings used by the corresponding printk
> 
> Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
> ---
> 
> For my previous patch ,Jiri Slaby told to investigate further as I have used uport->dev and there was a check for whether it is NULL. 
> For this patch instead of uport->dev , i have used tty_dev as that one gave a better desciption of the device than uport->dev.

Hi, that will not work either, as there is put_device(tty_dev) before
you use tty_dev.

-- 
js
suse labs
