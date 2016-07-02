From: Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: [RFC RESEND] serial: 8250: fix regression in 8250 uart driver
Date: Sat, 2 Jul 2016 13:53:17 +0200
Message-ID: <dbaa0abe-06ab-57ee-4ba3-4e4717af4a62@leemhuis.info>
References: <575F7325.3030907@kernel.org>
 <1465897220.30123.26.camel@linux.intel.com>
 <cca9fb6eca58d8a29e3070e3f34fa40f.squirrel@emailmg.ipower.com>
 <1465920046.30123.83.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1465920046.30123.83.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, dinh.linux@anniebear.net
Cc: Dinh Nguyen <dinguyen@kernel.org>, heikki.krogerus@linux.intel.com, peter@hurleysoftware.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 14.06.2016 18:00, Andy Shevchenko wrote:
> On Tue, 2016-06-14 at 10:27 -0500, dinh.linux@anniebear.net wrote:
>>> On Mon, 2016-06-13 at 21:59 -0500, Dinh Nguyen wrote:
>>> I suppose this one, i.e. commit dd4e91d538b3 ("dmaengine: slave
>>> means at
>>> least one of DMA_SLAVE, DMA_CYCLIC"), solves the issue.
>> Hmm...that commit didn't seem to fix my issue.
> [=E2=80=A6]
>> Does this mean that the 8250_dw.c driver can no longer use DMA?
>=20
> It means that previously the use of DMA engine whatever was used is n=
ot
> correct in your case. There is no issues in UART driver, the issue is=
 in
> DMA controller driver.
>=20
> I'm working on a quirk that will allow user to enforce PIO mode for
> Rx/Tx or both. In that case if DMA controller can't be fixed you stil=
l
> might use DMA for Tx.

What's the status of this issue? Just wondering, as this issue is liste=
d
in my regression reports for 4.7 and it seems nothing much happened for
more than a week now =E2=80=93 which is a bad sign as the 4.7 release s=
eems only
a week or two away.

CU, Thorsten
