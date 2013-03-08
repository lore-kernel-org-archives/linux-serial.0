From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH v4 25/32] tty: Add read-recursive, writer-prioritized rw
 semaphore
Date: Fri, 08 Mar 2013 12:12:42 -0500
Message-ID: <1362762762.4219.37.camel@thor.lan>
References: <1361390599-15195-1-git-send-email-peter@hurleysoftware.com>
	 <1361390599-15195-26-git-send-email-peter@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1361390599-15195-26-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, Sasha Levin <levinsasha928@gmail.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Wed, 2013-02-20 at 15:03 -0500, Peter Hurley wrote:
> The semantics of a rw semaphore are almost ideally suited
> for tty line discipline lifetime management;  multiple active
> threads obtain "references" (read locks) while performing i/o
> to prevent the loss or change of the current line discipline
> (write lock).
> 
> Unfortunately, the existing rw_semaphore is ill-suited in other
> ways;
> 1) obtaining a "reference" can be recursive, ie., a reference holder
>    may attempt to obtain another "reference". Recursive read locks
>    are not supported by rwsem.

Hi Greg,

I just finished auditing all the recursive usage of the tty/ldisc layer
and I can make this lock non-recursive.

Please hold off applying this and I'll send you a v5 series in a couple
of days, ok?

Regards,
Peter Hurley
