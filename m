From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH] tty: Prevent hw state corruption in exclusive mode reopen
Date: Tue, 30 Dec 2014 10:15:11 -0500
Message-ID: <54A2C17F.9030409@hurleysoftware.com>
References: <1419942873-6779-1-git-send-email-peter@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1419942873-6779-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Shreyas Bethur <shreyas.bethur@ni.com>
List-Id: linux-serial@vger.kernel.org

On 12/30/2014 07:34 AM, Peter Hurley wrote:
> Exclusive mode ttys (TTY_EXCLUSIVE) do not allow further reopens;
> fail the condition before associating the file pointer and calling
> the driver open() method.
> 
> Prevents DTR programming when the tty is already in exclusive mode.

Greg,

Please disregard. I'll redo a v2 that isn't broken.

Regards,
Peter Hurley
