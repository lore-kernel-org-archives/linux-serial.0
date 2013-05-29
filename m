From: Timur Tabi <timur@tabi.org>
Subject: Re: [PATCH] driver: tty: add missing unregister in err case
Date: Tue, 28 May 2013 21:37:02 -0500
Message-ID: <51A569CE.6010100@tabi.org>
References: <51A568EC.2070103@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:7765 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759366Ab3E2ChH (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 28 May 2013 22:37:07 -0400
In-Reply-To: <51A568EC.2070103@huawei.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Libo Chen <clbchenlibo.chen@huawei.com>, Greg KH <gregkh@linuxfoundation.org>
Cc: jslaby@suse.cz, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, linux-serial@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Li Zefan <lizefan@huawei.com>

Libo Chen wrote:
> when platform_driver_register broken, we should unregister ucc_uart_driver
>
> Signed-off-by: Libo chen<libo.chen@huawei.com>

Acked-by: Timur Tabi <timur@tabi.org>

Thanks for catching this.

-- 
Timur Tabi
