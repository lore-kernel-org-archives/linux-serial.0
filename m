From: Greg KH <greg@kroah.com>
Subject: Re: Q: what is the need for console write callback if there is
	serial tx (start_tx) ?
Date: Fri, 16 Sep 2016 08:15:24 +0200
Message-ID: <20160916061524.GB17855@kroah.com>
References: <CAJ2oMhJQhazxs=G6oUB4mhFVy7=7p__+1z1Yq-MpJ0X6EtUVqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kernelnewbies-bounces@kernelnewbies.org>
Content-Disposition: inline
In-Reply-To: <CAJ2oMhJQhazxs=G6oUB4mhFVy7=7p__+1z1Yq-MpJ0X6EtUVqg@mail.gmail.com>
List-Unsubscribe: <https://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies>,
	<mailto:kernelnewbies-request@kernelnewbies.org?subject=unsubscribe>
List-Archive: <http://lists.kernelnewbies.org/pipermail/kernelnewbies>
List-Post: <mailto:kernelnewbies@kernelnewbies.org>
List-Help: <mailto:kernelnewbies-request@kernelnewbies.org?subject=help>
List-Subscribe: <https://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies>,
	<mailto:kernelnewbies-request@kernelnewbies.org?subject=subscribe>
Sender: kernelnewbies-bounces@kernelnewbies.org
Errors-To: kernelnewbies-bounces@kernelnewbies.org
To: Ran Shalit <ranshalit@gmail.com>
Cc: linux-serial@vger.kernel.org, kernelnewbies <kernelnewbies@kernelnewbies.org>
List-Id: linux-serial@vger.kernel.org

On Thu, Sep 15, 2016 at 11:19:51PM +0300, Ran Shalit wrote:
> Hello,
> 
> I am writing a driver with serial tx/rx.

Great!  For what type of hardware?

> I am not sure what is the need console routines, when there is
> serial/uart tx/rx.
> 
> Isn't writing to console, the same as outputing chars to serial ?
> 
> I've tried to find information on this, but found none.

Just follow the "normal" tty api and your driver should be fine and work
with all sorts of consoles and programs and line disciplines.

good luck!

greg k-h
