From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH 2/2] serial: core: Preserve termios c_cflag for console
 resume
Date: Wed, 04 Jun 2014 10:46:40 -0400
Message-ID: <538F3150.6040102@hurleysoftware.com>
References: <7EC4C3FDEFF6492F91DEE16AEE0831E6@vanni.it> <1401891371-4946-1-git-send-email-peter@hurleysoftware.com> <1401891371-4946-2-git-send-email-peter@hurleysoftware.com> <20140604142232.GB1008@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140604142232.GB1008@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Valerio Vanni <valerio.vanni@inwind.it>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-serial@vger.kernel.org

On 06/04/2014 10:22 AM, Greg Kroah-Hartman wrote:
> On Wed, Jun 04, 2014 at 10:16:11AM -0400, Peter Hurley wrote:
>> When a tty is opened for the serial console, the termios c_cflag
>> settings are inherited from the console line settings.
>> However, if the tty is subsequently closed, the termios settings
>> are lost. This results in a garbled console if the console is later
>> suspended and resumed.
>>
>> Preserve the termios c_cflag for the serial console when the tty
>> is shutdown; this reflects the most recent line settings.
>>
>> Fixes: Bugzilla #69751, 'serial console does not wake from S3'
>> Reported-by: Valerio Vanni <valerio.vanni@inwind.it>
>> Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
>> Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
>> ---
>>   drivers/tty/serial/serial_core.c | 3 +++
>>   1 file changed, 3 insertions(+)
>
> Same as before, regression, or just a normal "new feature"?

This was reported as a regression since 2.6.24, but that was likely
misreported, and more likely due to a userspace update which triggers
the bug.

I would be surprised if console resume _never_ worked if the serial tty
was opened then closed, but it probably has worked for a long time.

Regards,
Peter Hurley
