/* Do not edit - auto-generated. */
static const struct {
	MuConfigCmd cmd;
	const char *usage;
	const char *long_help;
} MU_HELP_STRINGS[] = {
	{ MU_CONFIG_CMD_ADD,

	"mu add <file> [<files>]\n",

	"mu add is the command to add specific measage files to the database. Each of the\n"
	"files must be specified with an absolute path.\n"
	},

	{ MU_CONFIG_CMD_CFIND,

	"mu cfind [options] [--format=<format>] [<pattern>]\n",

	"mu cfind is the mu command to find contacts in the mu database and export them\n"
	"for use in other programs.\n"
	"\n"
	"<format> is one of:\n"
	" mutt-alias\n"
	" mutt-ab\n"
	" wl\n"
	" csv\n"
	" org-contact\n"
	" bbdb\n"
	},

	{ MU_CONFIG_CMD_EXTRACT,

	"mu extract [options] <file>\n",

	"mu extract is the mu command to display and save message parts\n"
	"(attachments), and open them with other tools.\n"
	},

	{ MU_CONFIG_CMD_FIND,

	"mu find [options] <search expression>\n",

	"mu find is the mu command for searching e-mail message that were\n"
	"stored earlier using mu index(1).\n"
	"\n"
	"Some examples:\n"
	" # get all messages with 'bananas' in body, subject or recipient fields:\n"
	" $ mu find bananas\n"
	"\n"
	" # get all messages regarding bananas from John with an attachment:\n"
	" $ mu find from:john flag:attach bananas\n"
	"\n"
	" # get all messages with subject wombat in June 2009\n"
	" $ mu find subject:wombat date:20090601..20090630\n"
	"\n"
	"See the `mu-find' and `mu-easy' man-pages for more information.\n"
	},

	{ MU_CONFIG_CMD_HELP,

	"mu help <command>\n",

	"mu find is the mu command to get help about <command>, where <command>\n"
	"is one of:\n"
	"  add     - add message to database\n"
	"  cfind   - find a contact\n"
	"  extract - extract parts/attachments from messages\n"
	"  find    - query the message database\n"
	"  help    - get help\n"
	"  index   - index messages\n"
	"  mkdir   - create a maildir\n"
	"  remove  - remove a message from the database\n"
	"  script  - run a script (available only when mu was built with guile-support)\n"
	"  server  - start mu server\n"
	"  verify  - verify signatures of a message\n"
	"  view    - view a specific message\n"
	},

	{ MU_CONFIG_CMD_INDEX,

	"mu index [options]\n",

	"mu index is the mu command for scanning the contents of Maildir\n"
	"directories and storing the results in a Xapian database.The\n"
	"data can then be queried using mu-find(1).\n"
	},

	{ MU_CONFIG_CMD_MKDIR,

	"mu mkdir [options] <dir> [<dirs>]\n",

	"mu mkdir is the mu command for creating Maildirs.It does not\n"
	"use the mu database.\n"
	},

	{ MU_CONFIG_CMD_REMOVE,

	"mu remove [options] <file> [<files>]\n",

	"mu remove is the mu command to remove messages from the database.\n"
	},

	{ MU_CONFIG_CMD_SERVER,

	"mu server [options]\n",

	"mu server starts a simple shell in which one can query and\n"
	"manipulate the mu database.The output of the commands is terms\n"
	"of Lisp symbolic expressions (s-exps).mu server is not meant for\n"
	"use by humans; instead, it is designed specificallyfor the\n"
	"mu4e e-mail client.\n"
	},

	{ MU_CONFIG_CMD_SCRIPT,

	"mu script [--script=<script>] [<pattern>] [-v] -- [script-options]\n",

	"Without any parameter, list the available scripts. With <pattern>,\n"
	"list only those scripts whose name or one-line description matches it.\n"
	"With -v, give longer descriptions of each script.\n"
	"\n"
	"With --script=<script>, run the script whose name is <script>; pass\n"
	"any arguments to the script after the '--' double-dash.\n"
	"\n"
	"Some examples:\n"
	"List all available scripts (one-line descriptions):\n"
	"  $ mu script\n"
	"\n"
	"List all available scripts matching 'month' (long descriptions):\n"
	"  $ mu script -v month\n"
	"\n"
	"Run the 'msgs-per-month' script, and pass it the '--textonly' parameter:\n"
	"  $ mu script --script=msgs-per-month -- --textonly\n"
	"(as mentioned, parameters to the script follow the '--')\n"
	},

	{ MU_CONFIG_CMD_VERIFY,

	"mu verify [options] <msgfile>\n",

	"mu verify is the mu command for verifying message signatures\n"
	"(such as PGP/GPG signatures)and displaying information about them.\n"
	"The command works on message files, and does not require\n"
	"the message to be indexed in the database.\n"
	},

	{ MU_CONFIG_CMD_VIEW,

	"mu view [options] <file> [<files>]\n",

	"mu view is the mu command for displaying e-mail message files. It\n"
	"works on message files and does not require the message to be\n"
	"indexed in the database.\n"
	},

};
/* the end */
