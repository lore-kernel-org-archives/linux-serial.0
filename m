From: Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH 1/2] serial: xilinx_uartps: Fix warnings in the driver
Date: Mon, 10 Jun 2019 17:06:57 +0200
Message-ID: <888c7d0a-28dc-978c-662a-e96ee3863c41@xilinx.com>
References: <c6753260caf8b20cc002b15fcbf22b759c91d760.1560156294.git.michal.simek@xilinx.com>
 <20190610144425.GC31086@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190610144425.GC31086@kroah.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>, Michal Simek <michal.simek@xilinx.com>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu, johan@kernel.org, Nava kishore Manne <nava.manne@xilinx.com>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On 10. 06. 19 16:44, Greg KH wrote:
> On Mon, Jun 10, 2019 at 10:44:55AM +0200, Michal Simek wrote:
>> From: Nava kishore Manne <nava.manne@xilinx.com>
>>
>> This patch fixes the below warning
>>
>>         -->Symbolic permissions 'S_IRUGO' are not preferred.
>>            Consider using octal permissions '0444'.
>>         -->macros should not use a trailing semicolon.
>>         -->line over 80 characters.
>>         -->void function return statements are not generally useful.
>>         -->Prefer 'unsigned int' to bare use of 'unsigned'.
>>
>> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>> ---
>>
>> Happy to split it if needed.
> 
> Please split.  Do not do more than one "logical thing" per patch.
> 
> And the subject is not correct, there are no general "warnings", these
> are all checkpatch warnings, not a build issue.

ok. Will do. Any issue with second patch?

Thanks,
Michal
