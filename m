From: Huang Shijie <b32955@freescale.com>
Subject: Re: [PATCH 2/2] serial: mxs-auart: put the device in mxs_auart_probe()
Date: Fri, 7 Sep 2012 10:48:36 +0800
Message-ID: <50496084.3090400@freescale.com>
References: <1346985521-2248-1-git-send-email-shijie8@gmail.com> <1346985521-2248-2-git-send-email-shijie8@gmail.com> <20120907024349.GH26709@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from db3ehsobe001.messaging.microsoft.com ([213.199.154.139]:2764
	"EHLO db3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757738Ab2IGCqi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 6 Sep 2012 22:46:38 -0400
In-Reply-To: <20120907024349.GH26709@S2101-09.ap.freescale.net>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Huang Shijie <shijie8@gmail.com>, gregkh@linuxfoundation.org, alan@linux.intel.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

=E4=BA=8E 2012=E5=B9=B409=E6=9C=8807=E6=97=A5 10:43, Shawn Guo =E5=86=99=
=E9=81=93:
> On Thu, Sep 06, 2012 at 10:38:41PM -0400, Huang Shijie wrote:
>> We call the get_device() in the mxs_auart_probe().
>> For the balance of the reference count, we should put the
>> device in the mxs_auart_remove().
>>
>> Signed-off-by: Huang Shijie<shijie8@gmail.com>
>> ---
>>   drivers/tty/serial/mxs-auart.c |    1 +
>>   1 files changed, 1 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs=
-auart.c
>> index ea5f888..6898413 100644
>> --- a/drivers/tty/serial/mxs-auart.c
>> +++ b/drivers/tty/serial/mxs-auart.c
>> @@ -796,6 +796,7 @@ static int __devexit mxs_auart_remove(struct pla=
tform_device *pdev)
>>
>>   	auart_port[pdev->id] =3D NULL;
>>
>> +	put_device(s->dev);
>>   	clk_put(s->clk);
>>   	free_irq(s->irq, s);
>>   	kfree(s);
> So the error path of probe needs function fixing too, right?
>
OK.

Send out the new version right now.


Huang Shijie

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
