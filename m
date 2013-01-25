From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH 2/2] serial: of: allow au1x00 and rt288x to load from
 OF
Date: Fri, 25 Jan 2013 15:44:33 +0400
Message-ID: <51027021.8010802@mvista.com>
References: <1359111008-9998-1-git-send-email-blogic@openwrt.org> <1359111008-9998-2-git-send-email-blogic@openwrt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-lb0-f172.google.com ([209.85.217.172]:64184 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753657Ab3AYLou (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 25 Jan 2013 06:44:50 -0500
Received: by mail-lb0-f172.google.com with SMTP id n8so553060lbj.3
        for <linux-serial@vger.kernel.org>; Fri, 25 Jan 2013 03:44:48 -0800 (PST)
In-Reply-To: <1359111008-9998-2-git-send-email-blogic@openwrt.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: John Crispin <blogic@openwrt.org>
Cc: Alan Cox <alan@linux.intel.com>, linux-serial@vger.kernel.org, linux-mips@linux-mips.org

Hello.

On 25-01-2013 14:50, John Crispin wrote:

> In order to make serial_8250 loadable via OF on Au1x00 and Ralink WiSoC we need
> to default the iotype to UPIO_AU.

    Alan Cox no longer works on Linux, Greg KH looks after the serial drivers 
snow.

> Signed-off-by: John Crispin <blogic@openwrt.org>

WBR, Sergei


