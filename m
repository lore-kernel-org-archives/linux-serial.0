From: Ran Shalit <ranshalit@gmail.com>
Subject: Q: what is the need for console write callback if there is serial tx
	(start_tx) ?
Date: Thu, 15 Sep 2016 23:19:51 +0300
Message-ID: <CAJ2oMhJQhazxs=G6oUB4mhFVy7=7p__+1z1Yq-MpJ0X6EtUVqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kernelnewbies-bounces@kernelnewbies.org>
List-Unsubscribe: <https://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies>,
	<mailto:kernelnewbies-request@kernelnewbies.org?subject=unsubscribe>
List-Archive: <http://lists.kernelnewbies.org/pipermail/kernelnewbies>
List-Post: <mailto:kernelnewbies@kernelnewbies.org>
List-Help: <mailto:kernelnewbies-request@kernelnewbies.org?subject=help>
List-Subscribe: <https://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies>,
	<mailto:kernelnewbies-request@kernelnewbies.org?subject=subscribe>
Sender: kernelnewbies-bounces@kernelnewbies.org
Errors-To: kernelnewbies-bounces@kernelnewbies.org
To: linux-serial@vger.kernel.org, kernelnewbies <kernelnewbies@kernelnewbies.org>
List-Id: linux-serial@vger.kernel.org

Hello,

I am writing a driver with serial tx/rx.
I am not sure what is the need console routines, when there is
serial/uart tx/rx.

Isn't writing to console, the same as outputing chars to serial ?

I've tried to find information on this, but found none.

Thank you,
Ran
