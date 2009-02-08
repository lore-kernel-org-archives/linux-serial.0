From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: [PATCH 1/2] PCI: quirks, don't mark one netmos as class other
Date: Sun, 08 Feb 2009 22:58:39 +0100
Message-ID: <498F558F.109@gmail.com>
References: <1228749555-21363-1-git-send-email-jirislaby@gmail.com> <200812091453.32105.jbarnes@virtuousgeek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <200812091453.32105.jbarnes@virtuousgeek.org>
Sender: linux-pci-owner@vger.kernel.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: akpm@linux-foundation.org, linux-serial@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Jesse Barnes wrote:
> On Monday, December 08, 2008 7:19 am Jiri Slaby wrote:
>> Let it as serial, since it doesn't have subdevice in the form of 0x00PS.
>>
>> Signed-off-by: Jiri Slaby <jirislaby@gmail.com>
>> Cc: Jesse Barnes <jbarnes@virtuousgeek.org>
> 
> Applied to my linux-next branch, thanks.

Hi, did this get lost by a chance? I don't see it in your -next branch
anymore. Neither in any other branch nor upstream.

BTW I got:
This patch was dropped because it was merged into mainline or a subsystem tree
from Andrew, so it had to be somewhere, I suppose...
