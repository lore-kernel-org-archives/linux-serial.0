From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH 4/4] serial: xuartps: Rewrite the interrupt handling logic
Date: Mon, 17 Aug 2015 14:46:26 -0400
Message-ID: <55D22C02.5000702@hurleysoftware.com>
References: <5b154ba97bcd79e49e2131152eb2fc1761594a6c.1439796149.git.michal.simek@xilinx.com> <ead0c38140e815133a47797a2527229a2fc077c1.1439796149.git.michal.simek@xilinx.com> <55D2040F.1010205@hurleysoftware.com> <59506B47DEDD3943ABF9AC60020F4E2978D6E80A@XAP-PVEXMBX02.xlnx.xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <59506B47DEDD3943ABF9AC60020F4E2978D6E80A@XAP-PVEXMBX02.xlnx.xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Anirudha Sarangi <anirudha.sarangi@xilinx.com>
Cc: Michal Simek <michals@xilinx.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "monstr@monstr.eu" <monstr@monstr.eu>, Soren Brinkmann <sorenb@xilinx.com>, Jiri Slaby <jslaby@suse.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On 08/17/2015 12:00 PM, Anirudha Sarangi wrote:
>> From: Peter Hurley [mailto:peter@hurleysoftware.com]
>> On 08/17/2015 03:22 AM, Michal Simek wrote:
>>> From: Anirudha Sarangi <anirudha.sarangi@xilinx.com>
>>>
>>> The existing interrupt handling logic has followins issues.
>>> - Upon a parity error with default configuration, the control
>>>   never comes out of the ISR thereby hanging Linux.
>>> - The error handling logic around framing and parity error are buggy.
>>>   There are chances that the errors will never be captured.
>>> - The existing ISR is just too long.
>>> This patch fixes all these concerns.
>>
>> This patch is unreviewable. Please break this down into multiple patches.
>>
> Thanks. Let me give a shot. It is just breaking the single big ISR that has both Rx and Tx in a single function into smaller ones.
> Not sure how I will create smaller patches, but I will try and get back.

I would start with a refactor patch that splits up the ISR but
makes no other functional changes. Then add the bug fix patches.

Regards,
Peter Hurley

ps - The email signature below is not appropriate for lkml.

> 
> This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
> 
