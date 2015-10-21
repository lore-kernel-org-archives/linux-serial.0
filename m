From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH] Fix data loss in cdc-acm
Date: Wed, 21 Oct 2015 10:58:56 -0400
Message-ID: <5627A830.6050609@hurleysoftware.com>
References: <55AC1883.4050605@svenbrauch.de>
 <20150720172546.GF20628@localhost> <55AD38E5.1090807@svenbrauch.de>
 <1437486195.3823.13.camel@suse.com> <55AEBD06.6020402@svenbrauch.de>
 <55AED708.903@hurleysoftware.com> <55AEE805.9050204@svenbrauch.de>
 <55B01554.90201@hurleysoftware.com> <55B01EDE.3050503@svenbrauch.de>
 <55C249A3.6030809@hurleysoftware.com> <562684F4.1020501@hurleysoftware.com>
 <1445422352.2246.22.camel@suse.com> <56278073.6030700@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56278073.6030700@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Oliver Neukum <oneukum@suse.com>
Cc: Johan Hovold <johan@kernel.org>, Sven Brauch <mail@svenbrauch.de>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Toby Gray <toby.gray@realvnc.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, linux-usb@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 10/21/2015 08:09 AM, Peter Hurley wrote:
> Be aware that while the N_TTY line discipline ensures that put_char()
> and write() usage will not be interleaved without flush_chars(), other
> line disciplines might not, so at least be sure that driver won't
> crash if that happens.

Sorry, I take that back: certain echoes are output via write() in
OPOST mode, specifically for O_ONLCR and XTABS.
