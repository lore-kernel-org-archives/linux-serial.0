From: Frans Klaver <fransklaver@gmail.com>
Subject: Re: [PATCH 2/4] serial: 8250_dw: Add UPF_SKIP_TEST to flags depend on
 device tree
Date: Thu, 23 Jul 2015 08:46:57 +0200
Message-ID: <CAH6sp9NN6UBbPDrR_nMi14zqj-EE7PwQppMc-WM3y5ovytCv=A@mail.gmail.com>
References: <1437557699-25722-1-git-send-email-noamc@ezchip.com>
	<1437557699-25722-2-git-send-email-noamc@ezchip.com>
	<1437557699-25722-3-git-send-email-noamc@ezchip.com>
	<55AF8A8E.9070706@hurleysoftware.com>
	<DB4PR02MB272917ED7AC857977C006CDD6820@DB4PR02MB272.eurprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <DB4PR02MB272917ED7AC857977C006CDD6820@DB4PR02MB272.eurprd02.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Noam Camus <noamc@ezchip.com>
Cc: Peter Hurley <peter@hurleysoftware.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "Alexey.Brodkin@synopsys.com" <Alexey.Brodkin@synopsys.com>, "vgupta@synopsys.com" <vgupta@synopsys.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "jslaby@suse.com" <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

On Thu, Jul 23, 2015 at 8:21 AM, Noam Camus <noamc@ezchip.com> wrote:
> From: Peter Hurley [mailto:peter@hurleysoftware.com]
> Sent: Wednesday, July 22, 2015 3:21 PM
>
>>>On 07/22/2015 05:34 AM, Noam Camus wrote:
>>> From: Noam Camus <noamc@ezchip.com>
>>>
>>> Add support for OF option "no-loopback-test"
>
>> Changes to devicetree need to at least get acks from DT maintainers.
> I will add them in my v2
> Should I take this patch apart from this set or should I add DT maintainers to whole set?

Add them at least to your cover letter and this one specifically. It's
a small set, so it's fine to add them to all patches, so they can see
the bigger picture. No need to take this patch out of the set (and
context).

Frans
