From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Subject: Re: [PATCH] USB: usb_wwan: fix handling of missing bulk endpoints
Date: Thu, 3 Apr 2014 13:32:19 +0200
Message-ID: <CACna6rxGKz9=qGGanC9T6KTAnMPCYuTLJxxY+KG6NzdZKYmrzQ@mail.gmail.com>
References: <20140403101729.GG22587@localhost>
	<1396523206-19973-1-git-send-email-jhovold@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1396523206-19973-1-git-send-email-jhovold@gmail.com>
Sender: stable-owner@vger.kernel.org
To: Johan Hovold <jhovold@gmail.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, =?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dan Carpenter <dan.carpenter@oracle.com>, linux-serial@vger.kernel.org, Matthias Urlichs <smurf@smurf.noris.de>, stable <stable@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

2014-04-03 13:06 GMT+02:00 Johan Hovold <jhovold@gmail.com>:
> Fix regression introduced by commit 8e493ca1767d ("USB: usb_wwan: fix
> bulk-urb allocation") by making sure to require both bulk-in and out
> endpoints during port probe.

Ohh, that was quick! :)

This patch works for me:
[33050.103575] option 1-1.2:1.0: GSM modem (1-port) converter detected
[33050.103617] [usb_wwan_port_probe] bulk_in_size:0 bulk_out_size:0
[33050.103653] option 1-1.2:1.1: GSM modem (1-port) converter detected
[33050.103676] [usb_wwan_port_probe] bulk_in_size:0 bulk_out_size:0
[33050.103712] option 1-1.2:1.3: GSM modem (1-port) converter detected
[33050.103737] [usb_wwan_port_probe] bulk_in_size:512 bulk_out_size:512
[33050.103799] usb 1-1.2: GSM modem (1-port) converter now attached to ttyUSB2
(out of curiosity I added one pr_info to print sizes).

Thank you!
