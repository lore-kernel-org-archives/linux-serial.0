From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] serial: imx: fix clk_prepare/unprepare usage
Date: Mon, 16 Nov 2015 10:49:01 -0200
Message-ID: <CAOMZO5D0r6vsMA-XZMxzhfbCL0SzqTfd_gh=oOLWTZK5gctA0w@mail.gmail.com>
References: <1447322328-5171-1-git-send-email-marcus.folkesson@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1447322328-5171-1-git-send-email-marcus.folkesson@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Thu, Nov 12, 2015 at 7:58 AM, Marcus Folkesson
<marcus.folkesson@gmail.com> wrote:
> clk_prepare/unprapare APIs are not allowed in atomic context, so
> move prepare/unprepare to probe/remove and use clk_enable/disable
> instead.
>
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>

Looks like you are using an older kernel.

Please check 0c727a42043f79db2.
