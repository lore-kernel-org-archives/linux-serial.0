From: David Sterba <dsterba@suse.cz>
Subject: Re: [PATCH 1/7] tty: ipwireless, cleanup TIOCGSERIAL
Date: Mon, 9 May 2016 09:32:04 +0200
Message-ID: <20160509073204.GI29353@suse.cz>
References: <1462777919-10367-1-git-send-email-jslaby@suse.cz>
Reply-To: dsterba@suse.cz
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1462777919-10367-1-git-send-email-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: gregkh@linuxfoundation.org, Jiri Kosina <jikos@kernel.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Mon, May 09, 2016 at 09:11:53AM +0200, Jiri Slaby wrote:
> In ipwireless_get_serial_info, struct serial_struct is memset to 0 and
> then some members set to 0 explicitly.
> 
> Remove the latter as it is obviously superfluous.
> 
> And remove the retinfo check against NULL. copy_to_user will take care
> of that.
> 
> Part of hub6 cleanup series.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Jiri Kosina <jikos@kernel.org>
> Cc: David Sterba <dsterba@suse.com>

Acked-by: David Sterba <dsterba@suse.com>
