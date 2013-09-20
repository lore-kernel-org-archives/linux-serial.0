From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] serial: imx: Fix build warning when CONFIG_LPAE=y
Date: Fri, 20 Sep 2013 16:58:37 -0700
Message-ID: <CAOesGMiVokv0myzWDgOUwGypX3jtNYp3dm=QgeZDVaTqyMCYYA@mail.gmail.com>
References: <1379720865-6951-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ob0-f181.google.com ([209.85.214.181]:38572 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751324Ab3ITX6i (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 20 Sep 2013 19:58:38 -0400
Received: by mail-ob0-f181.google.com with SMTP id gq1so1371226obb.40
        for <linux-serial@vger.kernel.org>; Fri, 20 Sep 2013 16:58:38 -0700 (PDT)
In-Reply-To: <1379720865-6951-1-git-send-email-festevam@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kevin Hilman <khilman@linaro.org>, linux-serial@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

On Fri, Sep 20, 2013 at 4:47 PM, Fabio Estevam <festevam@gmail.com> wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>
> Building multi_v7_defconfig with CONFIG_LPAE=y leads to the following build
> warning:
>
> drivers/tty/serial/imx.c: In function 'imx_verify_port':
> drivers/tty/serial/imx.c:1542:6: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
>
> Fix the casting to get rid of the warning.
>
> Reported-by: Kevin Hilman <khilman@linaro.org>
> Reported-by: Olof Johansson <olof@lixom.net>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Already fixed by:

http://marc.info/?l=linux-kernel&m=137896012701204&w=2

(But sitting in Greg's queue due to the merge window).


-Olof
