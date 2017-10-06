From: =?UTF-8?Q?Fr=c3=a9d=c3=a9ric_Danis?= <frederic.danis.oss@gmail.com>
Subject: Re: [PATCH 0/2] ACPI serdev support
Date: Fri, 6 Oct 2017 19:36:27 +0200
Message-ID: <8645dbfb-ca09-340d-e610-6899a9b7dd8a@gmail.com>
References: <1507107090-15992-1-git-send-email-frederic.danis.oss@gmail.com>
 <A58D9E0F-99FC-4C13-95E8-F60EC61C18B2@holtmann.org>
 <25008d7b-db06-49ad-033f-63c0b72d9c34@gmail.com>
 <6cd58b2f-1ec8-c709-e983-98321bbfea70@gmail.com>
 <CAFXWsS9uhvB=5r83GC=aA=uujDvxfjnOvEUUviymNEM31fka5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <CAFXWsS9uhvB=5r83GC=aA=uujDvxfjnOvEUUviymNEM31fka5Q@mail.gmail.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
To: Ian W MORRISON <ianwmorrison@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Rob Herring <robh@kernel.org>, Sebastian Reichel <sre@kernel.org>, Loic Poulain <loic.poulain@gmail.com>, Johan Hovold <johan@kernel.org>, Lukas Wunner <lukas@wunner.de>, Hans de Goede <hdegoede@redhat.com>, "bluez mailin list (linux-bluetooth@vger.kernel.org)" <linux-bluetooth@vger.kernel.org>, linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org, Greg Kroah-Hartman <greg@kroah.com>
List-Id: linux-serial@vger.kernel.org

Hi Ian,

Le 06/10/2017 à 16:47, Ian W MORRISON a écrit :
> <snip>
>> It seems normal to me that BCM2EA4 is no more enumerated at ACPI level as
>> this is moved to serdev.
>> When removing 'if (ares->data.common_serial_bus.type !=
>> ACPI_RESOURCE_SERIAL_TYPE_UART)' you stop the serdev module finding the
>> Serial UART information. In this case it will not register the device and it
>> will fall back to previous behavior needing to use btattach to setup
>> Bluetooth.
>>
>> Can you share:
>> - btattach you are currently using,
>> - dmesg with with dynamic debug enabled for serdev and hci_uart modules
>> during boot (with Hans's patches, your MINIX Z83-4 patches and mine
>> patches).
>>
>> Regards,
>>
>> Fred
> Hi Fred,
>
> I've attached four (text) files:
>
> 1. btattach.txt - Details of the 'bluez' package that contains the
> 'btattach' I'm using.
> 2. dmesg.txt - 'dmesg' with with dynamic debug enabled for serdev and
> hci_uart modules. This doesn't seem to show much so have I provided
> what you wanted?
> 3. gitlog.txt - First few commits from the git log showing the kernel
> patches used to build the kernel (sent just for clarity).
> 4. working.txt - An extract from 'dmesg' when BCM2EA4 is enumerated
> from a kernel patched with the 'if' statement refered to above.
>
> Regards,
> Ian

Which tty is used for btattach?
Is this tty existing in /dev?

I took a look at dmesg.txt and I did not find any trace related to serdev.
On the T100, where ttyS4 is used for Bluetooth, I can see the following 
traces:
   [   11.732347] serial serial0: allocated controller 
0xffff880036229000 id 0
   [   11.732470] serial serial0-0: device serial0-0 registered
   [   11.732475] serial serial0: serdev0 registered: dev:ffff880036229000
   [   11.732478] serial serial0: tty port ttyS4 registered

If serdev registration failed you should at least get something like:
     serdev0 no devices registered: of:<> acpi:<>

So, just to be sure, is SERIAL_DEV_BUS and SERIAL_DEV_CTRL_TTYPORT 
enabled in your kernel?

Regards,

Fred

