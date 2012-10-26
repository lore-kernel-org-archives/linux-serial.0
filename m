From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH v4] serial/arc-uart: Add New Driver
Date: Fri, 26 Oct 2012 11:46:40 +0530
Message-ID: <508A2AC8.9000304@synopsys.com>
References: <1351146608-21044-1-git-send-email-vgupta@synopsys.com> <20121025183643.GA22504@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20121025183643.GA22504@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: alan@linux.intel.com, arc-linux-dev@synopsys.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Friday 26 October 2012 12:06 AM, Greg KH wrote:
> On Thu, Oct 25, 2012 at 12:00:07PM +0530, Vineet.Gupta1@synopsys.com wrote:
>> From: Vineet Gupta <vgupta@synopsys.com>
>>
>> Hi Greg,
>>
>> Rebased off of tty-next and verfied that it builds fine.
> Did you run it?

Absolutely ! What I meant was, this specific version (rebased off of
tty-next) can't be run for ARC platform yet (for which this driver is
originally meant). The preceding version based off of 3.6 (including all
of Alan's review comments) already runs for our 3.6 kernel.

>
>> Please consider applying.
> I can't, see my review comments.

Updated revision to follow

Thx,
-Vineet
>
> thanks,
>
> greg k-h
