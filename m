From: Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 10/10] Bluetooth: add nokia driver
Date: Tue, 7 Mar 2017 22:20:27 +0100
Message-ID: <65D9766C-9BED-42D5-931C-65044530E215@holtmann.org>
References: <20170304115833.3538-1-sre@kernel.org>
 <20170304115833.3538-11-sre@kernel.org>
 <CAL_Jsq+PvqS_tU6wRzpcsdESYxOOU_JJqsacEc9qLDs2PB2VLw@mail.gmail.com>
 <20170307210837.w5fdwc2sy3xmzci7@earth>
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170307210837.w5fdwc2sy3xmzci7@earth>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "Gustavo F. Padovan" <gustavo-THi1TnShQwVAfugRpC6u6w@public.gmane.org>, Johan Hedberg <johan.hedberg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

Hi Sebastian,

>>> This adds a driver for the Nokia H4+ protocol, which is used
>>> at least on the Nokia N9, N900 & N950.
>>> 
>>> Signed-off-by: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>>> ---
>>> .../devicetree/bindings/net/nokia-bluetooth.txt    |  51 ++
>> 
>> This should be separate and before the dts files.
>> 
>>> drivers/bluetooth/Kconfig                          |  12 +
>>> drivers/bluetooth/Makefile                         |   2 +
>>> drivers/bluetooth/hci_nokia.c                      | 839 +++++++++++++++++++++
>>> 4 files changed, 904 insertions(+)
>>> create mode 100644 Documentation/devicetree/bindings/net/nokia-bluetooth.txt
>>> create mode 100644 drivers/bluetooth/hci_nokia.c
>>> 
>>> diff --git a/Documentation/devicetree/bindings/net/nokia-bluetooth.txt b/Documentation/devicetree/bindings/net/nokia-bluetooth.txt
>>> new file mode 100644
>>> index 000000000000..6c80a92f31e2
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/net/nokia-bluetooth.txt
>>> @@ -0,0 +1,51 @@
>>> +Nokia Bluetooth Chips
>>> +---------------------
>>> +
>>> +Nokia phones often come with UART connected bluetooth chips from different
>>> +vendors and modified device API. Those devices speak a protocol named H4+
>>> +by Nokia, which is similar to the H4 protocol from the Bluetooth standard.
>>> +In addition to the H4 protocol it specifies two more UART status lines for
>>> +wakeup of UART transceivers to improve power management and a few new packet
>>> +types used to negotiate uart speed.
>>> +
>>> +Required properties:
>>> +
>>> + - compatible: should be one of the following:
>>> +   * "nokia,brcm,bcm2048"
>>> +   * "nokia,ti,wl1271-bluetooth"
>> 
>> Drop the chip vendors' prefix here. I don't really want to start a
>> pattern of 2 vendor prefixes.
> 
> Right, I think we discussed this before, but I don't remember the
> result. How about
> 
> - compatible: should contain "nokia,h4p-bluetooth" as well as one of the following:
> * "brcm,bcm2048-nokia"
> * "ti,wl1271-blueooth-nokia”

I never liked the term “h4p”. It is fundamentally just “bluetooth”. What are our plans for Broadcom, Intel etc. Bluetooth UARTs?

Regards

Marcel

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
