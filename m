From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH] Fix data loss in cdc-acm
Date: Wed, 22 Jul 2015 18:12:36 -0400
Message-ID: <55B01554.90201@hurleysoftware.com>
References: <55AC1883.4050605@svenbrauch.de> <20150720172546.GF20628@localhost> <55AD38E5.1090807@svenbrauch.de> <1437486195.3823.13.camel@suse.com> <55AEBD06.6020402@svenbrauch.de> <55AED708.903@hurleysoftware.com> <55AEE805.9050204@svenbrauch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55AEE805.9050204@svenbrauch.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sven Brauch <mail@svenbrauch.de>
Cc: Oliver Neukum <oneukum@suse.com>, Johan Hovold <johan@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Toby Gray <toby.gray@realvnc.com>, linux-usb@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Sven,

On 07/21/2015 08:47 PM, Sven Brauch wrote:
> On 22/07/15 01:34, Peter Hurley wrote:
>> I'd like to see that data, if you can, which will help me understand
>> at least the timing.
> Sure, please see below for the code which produced the output
> and the actual output. Let me know if you need anything else.
> This was run with the unmodified version of the driver, i.e. without
> my patch.

Thanks for this, which confirms that roughly 10.4ms elapses from
kworker schedule (of input into nearly empty tty buffers) to throttle
notification.

The premature unthrottle actually leads to the data loss but the throttling
with a mere 2K left is _way too late_.

10ms is a _really_ long time for a cpu not to attend to a kworker.
Which raises 2 questions:
1. What are the termios settings of the tty receiving input? Is it 'raw'
   mode or typical terminal mode (icanon, echo, etc.) or something else?
2. Are there RT threads that are hogging cpu time?

Regards,
Peter Hurley
