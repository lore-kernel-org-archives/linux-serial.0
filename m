From: "Mike Frysinger" <vapier.adi@gmail.com>
Subject: Re: [PATCH 11/12] [Blackfin] serial driver: ADSP-BF52x arch/mach support
Date: Wed, 30 Jan 2008 16:01:03 -0500
Message-ID: <8bd0f97a0801301301k3951fi8dbe52ed859c9165@mail.gmail.com>
References: <1201685412-29095-1-git-send-email-bryan.wu@analog.com>
	 <1201685412-29095-12-git-send-email-bryan.wu@analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from el-out-1112.google.com ([209.85.162.183]:38549 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753342AbYA3VBF (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 30 Jan 2008 16:01:05 -0500
Received: by el-out-1112.google.com with SMTP id v27so178255ele.23
        for <linux-serial@vger.kernel.org>; Wed, 30 Jan 2008 13:01:04 -0800 (PST)
In-Reply-To: <1201685412-29095-12-git-send-email-bryan.wu@analog.com>
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Bryan Wu <bryan.wu@analog.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Michael Hennerich <michael.hennerich@analog.com>

On Jan 30, 2008 4:30 AM, Bryan Wu <bryan.wu@analog.com> wrote:
>  config SERIAL_BFIN_UART1
>         bool "Enable UART1"
> -       depends on SERIAL_BFIN && (BF534 || BF536 || BF537 || BF54x)
> +       depends on SERIAL_BFIN && (BF52x || BF53x || BF54x)
>         help
>           Enable UART1

erp, i just noticed this is slightly wrong ... BF53x is not OK as the
BF533 family does not have a UART1 ... i committed the fix to our repo
so you can re-post a fixed version of this for inclusion ;)
-mike
