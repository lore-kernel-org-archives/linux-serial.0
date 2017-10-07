From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH 0/2] ACPI serdev support
Date: Sat, 7 Oct 2017 17:14:09 +0200
Message-ID: <20171007151409.GI2618@localhost>
References: <1507107090-15992-1-git-send-email-frederic.danis.oss@gmail.com>
 <A58D9E0F-99FC-4C13-95E8-F60EC61C18B2@holtmann.org>
 <25008d7b-db06-49ad-033f-63c0b72d9c34@gmail.com>
 <6cd58b2f-1ec8-c709-e983-98321bbfea70@gmail.com>
 <CAFXWsS9uhvB=5r83GC=aA=uujDvxfjnOvEUUviymNEM31fka5Q@mail.gmail.com>
 <8645dbfb-ca09-340d-e610-6899a9b7dd8a@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8645dbfb-ca09-340d-e610-6899a9b7dd8a@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: =?iso-8859-1?Q?Fr=E9d=E9ric?= Danis <frederic.danis.oss@gmail.com>
Cc: Ian W MORRISON <ianwmorrison@gmail.com>, Marcel Holtmann <marcel@holtmann.org>, Rob Herring <robh@kernel.org>, Sebastian Reichel <sre@kernel.org>, Loic Poulain <loic.poulain@gmail.com>, Johan Hovold <johan@kernel.org>, Lukas Wunner <lukas@wunner.de>, Hans de Goede <hdegoede@redhat.com>, "bluez mailin list (linux-bluetooth@vger.kernel.org)" <linux-bluetooth@vger.kernel.org>, linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org, Greg Kroah-Hartman <greg@kroah.com>
List-Id: linux-serial@vger.kernel.org

On Fri, Oct 06, 2017 at 07:36:27PM +0200, Frédéric Danis wrote:

> I took a look at dmesg.txt and I did not find any trace related to serdev.
> On the T100, where ttyS4 is used for Bluetooth, I can see the following 
> traces:
>    [   11.732347] serial serial0: allocated controller 
> 0xffff880036229000 id 0
>    [   11.732470] serial serial0-0: device serial0-0 registered
>    [   11.732475] serial serial0: serdev0 registered: dev:ffff880036229000
>    [   11.732478] serial serial0: tty port ttyS4 registered
> 
> If serdev registration failed you should at least get something like:
>      serdev0 no devices registered: of:<> acpi:<>

Only with debugging enabled (it's a dev_dbg).

Johan
