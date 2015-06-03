From: Christ van Willegen <cvwillegen@gmail.com>
Subject: Re: [Gta04-owner] [PATCH RFC 3/3] misc: Add w2g0004 gps receiver driver
Date: Wed, 3 Jun 2015 14:09:50 +0200
Message-ID: <CA+Ot1Oyb428UGQje9uKUp8-S0otndfCQmNoP8r_GnSZbCSj0BQ@mail.gmail.com>
References: <55492001.30806@hurleysoftware.com> <DE60E7AA-1BF4-4A68-9638-E09F85FD5C72@goldelico.com>
 <20150506092738.GB4508@amd> <A2594559-CA92-40C2-A06A-AC2483E85CB1@goldelico.com>
 <554A03A7.2000504@hurleysoftware.com> <D10E1092-E75F-48F7-86F1-F8987973CEB5@goldelico.com>
 <20150506123632.GA1764@leverpostej> <BD3D34DD-2FC8-44A2-89FA-35843065F50F@goldelico.com>
 <20150506141547.GB1764@leverpostej> <EA4AC398-CAEA-40E1-A998-BC528B3788E1@goldelico.com>
 <20150506171802.GE2974@leverpostej> <B4D487C5-C260-497B-A441-6C381D53616C@goldelico.com>
 <554B7D33.602@hurleysoftware.com> <9EF54D80-F634-4D59-BFD9-FC79FCFE06DE@goldelico.com>
 <554B8A14.2080904@hurleysoftware.com> <21C337B3-D612-4931-BA23-6B7518E6E4DD@goldelico.com>
 <112A49DF-935D-41DF-8DF7-F04CC13B9598@goldelico.com> <463356C5-E3C6-432C-A1C5-71F0287F1FEE@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <463356C5-E3C6-432C-A1C5-71F0287F1FEE@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: List for communicating with real GTA04 owners <gta04-owner@goldelico.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Peter Hurley <peter@hurleysoftware.com>, Arnd Bergmann <arnd@arndb.de>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Pavel Machek <pavel@ucw.cz>, linux-serial@vger.kernel.org, NeilBrown <neil@brown.name>, Marek Belisko <marek@goldelico.com>, Jiri Slaby <jslaby@suse.cz>
List-Id: linux-serial@vger.kernel.org

Hi all,

On Wed, Jun 3, 2015 at 1:51 PM, Dr. H. Nikolaus Schaller
<hns@goldelico.com> wrote:
> Add driver for Wi2Wi w2g004 GPS module connected through  uart. Use uart
> slave + notification hooks to glue with tty.

Just a _very_ minor documentation nit-pick here:

> +config W2SG0004
> +       tristate "W2SG0004 on/off control"
> +       depends on GPIOLIB
> +       help
> +         Enable on/off control of W2SG0004 GPS using a tty slave to
> +         to allow powering up if the /dev/tty$n is opened.

The 'to' at the start of the 2nd line here is better removed.

Christ van Willegen
