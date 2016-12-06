From: Timur Tabi <timur@tabi.org>
Subject: Re: [PATCH 1/1] serial/uuc_uart: Set shutdown timeout to CONFIG_HZ
 independent 2ms
Date: Tue, 6 Dec 2016 07:35:43 -0600
Message-ID: <5846BEAF.3040003@tabi.org>
References: <1480953058-4958-1-git-send-email-alexander.stein@systec-electronic.com>
 <5845900B.5010108@tabi.org> <18303458.zhjk47K7B1@ws-stein>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <18303458.zhjk47K7B1@ws-stein>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

Alexander Stein wrote:
> Okay, I was just wondering why the timeout is dependant on the timer tick.
> That didn't seem obvious to me.
> Rethinking about this, I would rather replace those lines with msleep instead.

What's wrong with leaving it as-is?  The code is five years old, and 
Freescale/NXP barely uses the QE any more.  I don't have access to any 
hardware to test any changes you would propose.
