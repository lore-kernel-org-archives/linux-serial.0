From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: Possible tty VT1 disallocate regression
Date: Fri, 14 Jun 2013 18:02:09 -0400
Message-ID: <51BB92E1.7040906@hurleysoftware.com>
References: <20130614204740.GA706@hobo.wolfson.cam.ac.uk> <20130614213543.GA1896@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130614213543.GA1896@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Ross Lagerwall <rosslagerwall@gmail.com>, linux-kernel@vger.kernel.org, Dave Jones <davej@redhat.com>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 06/14/2013 05:35 PM, Greg KH wrote:
> On Fri, Jun 14, 2013 at 09:47:40PM +0100, Ross Lagerwall wrote:
>> Hi,
>>
>> Ever since commit 421b40a6286e ("tty/vt: Fix vc_deallocate() lock
>> order"), the first VT does not clear when I log out.  AFAIK, this means
>> that disallocation is not working?  The problem only affects the first
>> VT, the others clear when logging out.
>
> And if you revert that patch, does it all start working again?
>
> thanks,
>
> greg k-h
>
> p.s. In the future, please cc: the people who handled the patch you are
> asking about, otherwise stuff like this often gets missed in the noise
> of lkml.

I've already been re-reviewing the VT indexing to see if or what I missed.

Thanks,
Peter Hurley
