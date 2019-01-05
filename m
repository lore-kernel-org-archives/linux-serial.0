From: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Subject: Re: [PATCH lora-next 3/5] net: lora: sx130x: Add PicoCell serdev
 driver
Date: Sat, 5 Jan 2019 02:32:54 +0100
Message-ID: <3792ea0c-2f31-8984-a1a6-b8a6f5c6eb8a@suse.de>
References: <20190104112131.14451-1-afaerber@suse.de>
 <20190104112131.14451-4-afaerber@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190104112131.14451-4-afaerber@suse.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: linux-lpwan@lists.infradead.org, linux-serial@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>, netdev@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
List-Id: linux-serial@vger.kernel.org

Am 04.01.19 um 12:21 schrieb Andreas Färber:
> diff --git a/drivers/net/lora/sx130x_picogw.c b/drivers/net/lora/sx130x_picogw.c
> new file mode 100644
> index 000000000000..577f9fb71d46
> --- /dev/null
> +++ b/drivers/net/lora/sx130x_picogw.c
[...]
> +	serdev_device_set_baudrate(sdev, 115200);
> +	serdev_device_set_parity(sdev, SERDEV_PARITY_NONE);
> +	serdev_device_set_flow_control(sdev, true);

This should probably be false?

https://github.com/Lora-net/picoGW_hal/blob/master/libloragw/src/loragw_com_linux.c#L65

tty.c_iflag &= ~(IXON | IXOFF | IXANY | ICRNL);
...
tty.c_oflag &= ~(IXON | IXOFF | IXANY | ICRNL);

Nothing that looks like RTS/CTS anywhere, which appears to be what the
serdev implementation is switching with the above function.

However, both true and false appeared to work equally so far.


With one particular USB device I get the following warning/error,
seemingly independent of whether I enable flow control above or not:

[68640.481454] lora-picogw-usb 4-1:1.0: failed to set dtr/rts

(imagine s/lora-picogw-usb/cdc_acm/ - cf. cdc-acm.c:acm_port_dtr_rts())

Looks like a firmware/hardware issue to me, since it appeared with the
original cdc_acm driver on reboot, plus across reset, ports and hosts.

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
