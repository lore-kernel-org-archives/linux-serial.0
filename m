From: Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH] serial: uartps: Fix uartps_major handling
Date: Fri, 4 Oct 2019 15:04:26 +0200
Message-ID: <bcc281df-0fcc-f870-842b-213d1539dbca@xilinx.com>
References: <00a269bc15c4f8c0a73c14958c5d7a5d37ff70ce.1568359707.git.michal.simek@xilinx.com>
 <20191004125203.GA583048@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191004125203.GA583048@kroah.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Michal Simek <michal.simek@xilinx.com>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu, git@xilinx.com, Paul Thomas <pthomas8589@gmail.com>, Jiri Slaby <jslaby@suse.com>, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 04. 10. 19 14:52, Greg Kroah-Hartman wrote:
> On Fri, Sep 13, 2019 at 09:28:29AM +0200, Michal Simek wrote:
>> There are two parts which should be fixed. The first one is to assigned
>> uartps_major at the end of probe() to avoid complicated logic when
>> something fails.
>> The second part is initialized uartps_major number to 0 when last device is
>> removed. This will ensure that on next probe driver will ask for new
>> dynamic major number.
>>
>> Fixes: c9712e333809 ("serial: uartps: Use the same dynamic major number for all ports")
> 
> This is not a valid sha1 in Linus's tree :(
> 
> Please fix up and resend.

grr. It is sha1 from stable tree. Will resend.

Thanks,
Michal
