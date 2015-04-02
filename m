From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH v3 -next 11/11] serial: 8250_early: Remove setup_early_serial8250_console()
Date: Thu, 2 Apr 2015 15:36:44 -0700
Message-ID: <CAE9FiQVaM650O139RgLcHRv7NGUVVMqSETq0YJ+7OAWVg=0Y0A@mail.gmail.com>
References: <1425932842-21812-1-git-send-email-peter@hurleysoftware.com>
	<1425932842-21812-12-git-send-email-peter@hurleysoftware.com>
	<CAE9FiQVWhfVt8kmj5QumAH2hyp+DRYGeQcBtFrynojXTCOdnQw@mail.gmail.com>
	<551CB5DF.1010108@hurleysoftware.com>
	<CAE9FiQVKY9KLeBOB0shqTPZZipsmAiU=3_8gzfFhsCW9kxo_uA@mail.gmail.com>
	<551D6EEA.6050704@hurleysoftware.com>
	<CAE9FiQUGeGuf9z0tQyjOujfRW_RtrWe8ELeKe=W6GNFmRVdpfg@mail.gmail.com>
	<CAE9FiQVBxGt_jX-juzf4vvc_6MgiiSixW6RtVTz1aUTw0h3Rmg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAE9FiQVBxGt_jX-juzf4vvc_6MgiiSixW6RtVTz1aUTw0h3Rmg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>, Rob Herring <robh@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Thu, Apr 2, 2015 at 3:12 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Thu, Apr 2, 2015 at 10:23 AM, Yinghai Lu <yinghai@kernel.org> wrote:
>> On Thu, Apr 2, 2015 at 9:31 AM, Peter Hurley <peter@hurleysoftware.com> wrote:
>>
>>> Would you please try the patch below instead?
>>>
>> Great. that works, and less lines change than my version.
>>
>
> still have another problem.
> when using console=uart8250,io,0x3f8
> it works as earlycon at first.
> but after handover to normal console
> it will revert back to 9600 again.

this regression should be caused by:

commit c7cef0a84912cab3c9df8949b034e4aa62982ec9
Author: Peter Hurley <peter@hurleysoftware.com>
Date:   Mon Mar 9 16:27:12 2015 -0400

    console: Add extensible console matching
